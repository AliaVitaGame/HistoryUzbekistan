using System;
using Unity.VisualScripting;
using UnityEngine;

public class PlayerAnimationController : MonoBehaviour
{
    [SerializeField] private PlayerMove _player;
    [SerializeField] private Animator _animator;

    private bool _isAttack;
    private RuntimeAnimatorController _startAnimatorController;

    private void OnEnable()
    {
        PlayerMove.StartDeadTeleportEvent += StartDeadAnimation;
    }

    private void OnDisable()
    {
        PlayerMove.StartDeadTeleportEvent -= StartDeadAnimation;
    }

    private void Start()
    {
        _startAnimatorController = _animator.runtimeAnimatorController;
    }

    private void Update()
    {
        Animation();
    }

    private void Animation()
    {
        if (_isAttack) return;

        bool isGround = _player.CharacterController.isGrounded;

        _animator.SetBool("Run", GetInputShift());
        _animator.SetBool("Move", GetInput());
        _animator.SetBool("Jump", isGround == false);
    }

    public void AttackAnimation(int animationID, bool active = true)
    {
        _animator.SetBool("Combat State", active);
        _animator.SetBool($"Attack{animationID}", active);
        _isAttack = active;
    }

    public void HitAnimation()
    {
        _animator.SetTrigger("Hit");
    }

    public void SetApplyRootMotion(bool active) 
        => _animator.applyRootMotion = active;

    public void ReturnStartingAnimator() 
        => SetAnimator(_startAnimatorController);

    public void SetAnimator(RuntimeAnimatorController animator)
        => _animator.runtimeAnimatorController = animator;

    private void StartDeadAnimation()
        => _animator.SetTrigger("Dead");

    private bool GetInputShift()
        => Input.GetKey(KeyCode.LeftShift) && GetInput();

    private bool GetInput()
       => _player.InpuZ != 0 || _player.InpuX != 0;

    public Animator GetAnimator() 
        => _animator;

}
