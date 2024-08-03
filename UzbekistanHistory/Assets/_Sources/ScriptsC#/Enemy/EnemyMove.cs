using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class EnemyMove : MonoBehaviour
{
    private bool _stopMove;
    public NavMeshAgent Agent { get; private set; }

    private void Start()
    {
        if (_stopMove) return;

        Agent = GetComponent<NavMeshAgent>();
    }

    public void SetStopMove(bool stopMove) => _stopMove = stopMove;
    public void MoveToPoint(Vector3 point) => Agent.SetDestination(point);
}
