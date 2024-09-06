using System;
using System.Collections;
using UnityEngine;

[RequireComponent(typeof(EnemyMove))]
[RequireComponent(typeof(EnemyAnimationController))]
public class EnemyAttaking : MonoBehaviour
{
    [SerializeField] private float attackRadius = 2;
    [SerializeField] private float aggressionRadius = 15;
    [SerializeField] private float timeAttack = 1;
    [SerializeField] private LayerMask layerTarget;
    [Space]
    [SerializeField] private WeaponDamageble weaponDamageble;
    [SerializeField] private WeaponScriptableObject weapon;

    public Action StartAttackEvent;
    public Action EndAttackEvent;

    private bool _isAttack;
    private Transform _target;
    private EnemyAnimationController _animation;
    private EnemyMove _enemyMove;

    private void Start()
    {
        _enemyMove = GetComponent<EnemyMove>();
        _animation = GetComponent<EnemyAnimationController>();
        weaponDamageble.SetStats(weapon.Damage, weapon.StunTime, layerTarget);
    }

    private void FixedUpdate()
    {
        if(_target == null)
        {
            if (Physics.CheckSphere(transform.position, aggressionRadius, layerTarget))
                FindTarget();
        }
        else AttackPlayer();
    }

    public void StartAttack()
    {
        if (_isAttack) return;

        _isAttack = true;
        _enemyMove.MoveToPoint(transform.position);
        StartCoroutine(Attack());
    }

    public IEnumerator Attack()
    {
        yield return new WaitForSeconds(0.1f);

        _isAttack = true;
        weaponDamageble.SetActiveCollision(true);
        StartAttackEvent?.Invoke();
        _enemyMove.SetStopMove(true);

        yield return new WaitForSeconds(1);
       //yield return new WaitForSeconds(_animation.GetStateInfo().length);

        _isAttack = false;
        weaponDamageble.SetActiveCollision(false);
        EndAttackEvent?.Invoke();
        _enemyMove.SetStopMove(false);
    }

    private void AttackPlayer()
    {
        if (_target == null) return;
        if (_isAttack) return;

        if (Vector3.Distance(transform.position, _target.position) <= attackRadius)
            StartAttack();
        else if(_isAttack == false)
            _enemyMove.MoveToPoint(_target.position);
    }

    private void FindTarget()
    {
        if (_target) return;

        var colliders = Physics.OverlapSphere(transform.position, aggressionRadius, layerTarget);

        for (int i = 0; i < colliders.Length; i++)
        {
            if (colliders[i])
            {
                _target = colliders[i].transform;
                return;
            }
        }
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, aggressionRadius);
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(transform.position, attackRadius);
    }

}
