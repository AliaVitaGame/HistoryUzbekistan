using System;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class PlayerMove : MonoBehaviour
{
    [SerializeField] private float _speedWalk = 5;
    [SerializeField] private float _speedRun = 15;
    [SerializeField] private float _speedRotation = 15;
    [SerializeField] private float _jumpForce = 0.2f;
    [SerializeField] private float _gravity = 0.5f;
    [SerializeField] private GameObject _character;
    [SerializeField] private Transform _pivotDirection;

    private bool _isStopMove;
    private float _gravitySpeed;
    private bool _isDead;

    public float InpuX { get; private set; }
    public float InpuZ { get; private set; }
    public CharacterController CharacterController { get; private set; }

    public static event Action StartDeadTeleportEvent;
    public static event Action EndetDeadTeleportEvent;

    private void Start()
    {
        CharacterController = GetComponent<CharacterController>();
    }

    private void FixedUpdate()
    {
        if (_isDead) return;

        InpuX = Input.GetAxis("Horizontal");
        InpuZ = Input.GetAxis("Vertical");

        if (_isStopMove) return;

        Jump();
        Move();
        Rotation();
    }

    public void Move()
    {
        Vector3 direction = _pivotDirection.transform.forward * InpuZ * GetSpeed() + _pivotDirection.transform.right * InpuX * GetSpeed();
        CharacterController.Move(new Vector3(direction.x, GetGravity(), direction.z));

        if (CharacterController.isGrounded) _gravitySpeed = -_gravity * 10 * Time.deltaTime;
    }

    private void Rotation()
    {
        if (InpuX != 0 || InpuZ != 0)
        {
            Vector3 direction = _pivotDirection.right * InpuX + _pivotDirection.forward * InpuZ;
            _character.transform.forward =
                Vector3.Lerp(_character.transform.forward, direction, _speedRotation * Time.deltaTime);
            var rotation = _character.transform.rotation;
            rotation.x = 0;
            rotation.z = 0;
            _character.transform.rotation = rotation;
        }

    }

    private void Jump()
    {
        if (Input.GetKey(KeyCode.Space) && CharacterController.isGrounded) _gravitySpeed = _jumpForce;
    }

    public float GetGravity()
    {
        if (CharacterController.isGrounded == false) _gravitySpeed -= _gravity * Time.deltaTime;
        return _gravitySpeed;
    }

    private float GetSpeed()
    {
        var speed = Input.GetKey(KeyCode.LeftShift) ? _speedRun * Time.deltaTime : _speedWalk * Time.deltaTime;
        return CharacterController.isGrounded ? speed : speed / 0.7f;
    }

    public void SetStopMove(bool stopMove) => _isStopMove = stopMove;
}
