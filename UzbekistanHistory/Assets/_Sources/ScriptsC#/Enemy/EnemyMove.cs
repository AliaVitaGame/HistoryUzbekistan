using UnityEngine;
using UnityEngine.AI;

[RequireComponent(typeof(NavMeshAgent))]
public class EnemyMove : MonoBehaviour
{
    private bool _stopMove;
    private float _startSpeedMove;
    public NavMeshAgent Agent { get; private set; }

    private void Start()
    {
        Agent = GetComponent<NavMeshAgent>();
        _startSpeedMove = Agent.speed;
    }

    public void SetStopMove(bool stopMove)
    {
        _stopMove = stopMove;
        SetSpeed(_stopMove ? 0 : _startSpeedMove);
    }
    public void SetSpeed(float speed) => Agent.speed = speed;
    public void MoveToPoint(Vector3 point) => Agent.SetDestination(point);
}
