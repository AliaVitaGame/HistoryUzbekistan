using System;
using System.Collections;
using UnityEngine;

[RequireComponent(typeof(EnemyMove))]
public class EnemyAttaking : MonoBehaviour
{
    [SerializeField] private float attackRadius = 2;
    [SerializeField] private float aggressionRadius = 15;
    [SerializeField] private LayerMask layerTarget;

    public Action StartAttackEvent;
    public Action EndAttackEvent;

    private bool _isAttack;
    private Transform _target;
    private EnemyMove _enemyMove;

    private void Start()
    {
        _enemyMove = GetComponent<EnemyMove>();
    }

    private void FixedUpdate()
    {
        if (Physics.CheckSphere(transform.position, aggressionRadius, layerTarget))
        {
            FindTarget();
            AttackPlayer();
        }
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
        StartAttackEvent?.Invoke();
        yield return new WaitForSeconds(1);
        _isAttack = false;
        EndAttackEvent?.Invoke();
    }

    private void AttackPlayer()
    {
        if (_target == null) return;

        if (Vector3.Distance(transform.position, _target.position) <= attackRadius)
            StartAttack();
        else
            _enemyMove.MoveToPoint(_target.position);
    }

    private void FindTarget()
    {
        if (_target) return;

        var colliders = Physics.OverlapSphere(transform.position, aggressionRadius, layerTarget);

        for (int i = 0; i < colliders.Length; i++)
        {
            if (colliders[i])
                _target = colliders[i].transform;
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
