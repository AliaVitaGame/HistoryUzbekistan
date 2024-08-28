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
        _pivotDirection.SetParent(null);
    }

    private void Update()
    {
        _pivotDirection.position = transform.position;
    }

    private void FixedUpdate()
    {
        if (_isDead) return;

        if (_isStopMove == false)
        {
            InpuX = Input.GetAxis("Horizontal");
            InpuZ = Input.GetAxis("Vertical");
        }
        else
        {
            InpuX = 0;
            InpuZ = 0;
        }

        Jump();
        Move();
        RotationModel();
    }

    public void Move()
    {
        Vector3 direction = _pivotDirection.transform.forward * InpuZ * GetSpeed() + _pivotDirection.transform.right * InpuX * GetSpeed();
        CharacterController.Move(new Vector3(direction.x, GetGravity(), direction.z));

        if (CharacterController.isGrounded) _gravitySpeed = -_gravity * 10 * Time.deltaTime;
    }

    private void RotationModel()
    {
        if (_isStopMove) return;
        if (InpuX != 0 || InpuZ != 0)
        {
            Vector3 direction = _pivotDirection.right * InpuX + _pivotDirection.forward * InpuZ;
            SetModelRotation(direction, _speedRotation);
        }
    }

    private void Jump()
    {
        if (_isStopMove) return;
        if (Input.GetKey(KeyCode.Space) && CharacterController.isGrounded) _gravitySpeed = _jumpForce;
    }

    public void SetRotation(Vector3 direction, float speed = Mathf.Infinity)
    {
        _pivotDirection.forward = Vector3.Lerp(_pivotDirection.forward, direction, speed * Time.deltaTime);
        transform.forward = Vector3.Lerp(transform.forward, direction, speed * Time.deltaTime);
        var rotation = transform.rotation;
        rotation.x = 0;
        rotation.z = 0;
        transform.rotation = rotation;
        _pivotDirection.forward = transform.forward;
    }

    public void SetModelRotation(Vector3 direction, float speed = Mathf.Infinity)
    {
        _character.transform.forward = Vector3.Lerp(_character.transform.forward, direction, speed * Time.deltaTime);
        var rotation = _character.transform.rotation;
        rotation.x = 0;
        rotation.z = 0;
        _character.transform.rotation = rotation;
    }

    public float GetGravity()
    {
        if (CharacterController.isGrounded == false) _gravitySpeed -= _gravity * Time.deltaTime;
        return _gravitySpeed;
    }

    public Transform GetPivotDirection() => _pivotDirection;

    private float GetSpeed()
    {
        var speed = Input.GetKey(KeyCode.LeftShift) ? _speedRun * Time.deltaTime : _speedWalk * Time.deltaTime;
        return CharacterController.isGrounded ? speed : speed / 0.7f;
    }

    public void SetStopMove(bool stopMove) => _isStopMove = stopMove;
}
