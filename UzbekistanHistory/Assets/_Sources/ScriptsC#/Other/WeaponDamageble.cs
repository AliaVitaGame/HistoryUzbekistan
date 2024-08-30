using UnityEngine;

public class WeaponDamageble : MonoBehaviour
{
    [SerializeField] private float radiusCollision = 0.8f;
    [SerializeField] private Vector3 centerCollision;

    private float _damage;
    private bool _activeCollision;
    private LayerMask _targetLayer;

    private void Start()
    {
        SetActiveCollision(false);
    }

    private void FixedUpdate()
    {
        if (_activeCollision == false) return;

        var tempObject = Physics.OverlapSphere(centerCollision + transform.position + transform.forward, radiusCollision, _targetLayer);

        if (tempObject == null) return;
        if (tempObject.Length <= 0) return;

        for (int i = 0; i < tempObject.Length; i++)
        {
            if (tempObject[i])
            {

                if (tempObject[i].TryGetComponent(out IUnitHealthStats unitHealth))
                    unitHealth.TakeDamage(_damage);
            }
        }
    }

    public void SetActiveCollision(bool value)
        => _activeCollision = value;

    public void SetStats(float damagem, LayerMask layerTarget)
    {
        _damage = damagem;
        SetLayerTarget(layerTarget);
    }

    public void SetLayerTarget(LayerMask mask)
        => _targetLayer = mask;

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.green;
        Gizmos.DrawWireSphere(centerCollision + transform.position + transform.forward, radiusCollision);
    }
}
