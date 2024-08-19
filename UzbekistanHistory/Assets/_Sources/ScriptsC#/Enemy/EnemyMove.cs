using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class EnemyMove : MonoBehaviour
{
    [SerializeField] private float speedWalk;
    [SerializeField] private float speedRun;
    [SerializeField] private float distanceForWalk = 3;

    private bool _stopMove;
    public bool IsRunning { get; private set; }
    public NavMeshAgent Agent { get; private set; }

    private void Start()
    {
        Agent = GetComponent<NavMeshAgent>();
    }

    public void SetStopMove(bool stopMove)
    {
        _stopMove = stopMove;
       // SetSpeed(_stopMove ? 0 : _startSpeedMove);
    }
    public void SetSpeed(float speed) => Agent.speed = speed;

    public void MoveToPoint(Vector3 point)
    {
        IsRunning = Vector3.Distance(transform.position, point) > distanceForWalk;
        SetSpeed(IsRunning ? speedRun : speedWalk);
        Agent.SetDestination(point);
    }
}
