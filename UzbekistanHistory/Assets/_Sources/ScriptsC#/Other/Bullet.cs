using UnityEngine;

[RequireComponent(typeof(CapsuleCollider2D))]
public class Bullet : MonoBehaviour
{
    private float _damage;
    private float _speedMove;
    private float _timeStun;
    private float _repulsion;
    private bool _autoGuidance;
    private Transform _target;

    private Vector2 _directionMoveX;

    public void SetStats(float damage, float speedMove, float timeStun, float repulsion, Transform target, Transform ignorCollision, bool autoGuidance, float lifeTime = 7)
    {
        _damage = damage;
        _speedMove = speedMove;
        _timeStun = timeStun;
        _repulsion = repulsion;
        _target = target;
        _autoGuidance = autoGuidance;

        Destroy(gameObject, lifeTime);

        Physics2D.IgnoreCollision(GetComponent<Collider2D>(), ignorCollision.GetComponent<Collider2D>(), true);

        CheckTarget();

        if (_autoGuidance == false)
        {
            var directionX = _target.position.x > transform.position.x ? 1 : -1;
            _directionMoveX = Vector2.right * directionX;
        }
    }

    private void FixedUpdate()
    {
        CheckTarget();

        if (_autoGuidance == false) Move(_directionMoveX + (Vector2)transform.position);
        else Move(_target.position);
    }

    private void Move(Vector3 point)
    {
        var speed = _speedMove * Time.fixedDeltaTime;
        var direction = Vector2.MoveTowards(transform.position, point, speed);
        transform.position = direction;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.TryGetComponent(out IUnitHealthStats unit))
            Damage(unit);
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.transform.TryGetComponent(out IUnitHealthStats unit))
            Damage(unit);
    }

    private void Damage(IUnitHealthStats target)
    {
        CheckTarget();

        target.TakeDamage(_damage, _timeStun, _repulsion);

        Kill();
    }

    private void CheckTarget()
    {
        if (_target == null)
            Kill();
    }

    private void Kill() => Destroy(gameObject);
}
