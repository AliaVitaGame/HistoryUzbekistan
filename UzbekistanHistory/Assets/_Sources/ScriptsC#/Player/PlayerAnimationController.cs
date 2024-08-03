using UnityEngine;

public class PlayerAnimationController : MonoBehaviour
{
    [SerializeField] private PlayerMove _player;
    [SerializeField] private Animator _playerAnimator;

    private void OnEnable()
    {
        PlayerMove.StartDeadTeleportEvent += StartDeadAnimation;
    }

    private void OnDisable()
    {
        PlayerMove.StartDeadTeleportEvent -= StartDeadAnimation;
    }


    private void Update()
    {
        Animation();
    }

    private void Animation()
    {
        bool isGround = _player.CharacterController.isGrounded;

        _playerAnimator.SetBool("Run", GetInputShift());
        _playerAnimator.SetBool("Move", GetInput());
        _playerAnimator.SetBool("Jump", isGround == false);
    }

    public void SetAnimator(RuntimeAnimatorController animator)
        => _playerAnimator.runtimeAnimatorController = animator;

    private void StartDeadAnimation()
        => _playerAnimator.SetTrigger("Dead");

    private bool GetInputShift()
        => Input.GetKey(KeyCode.LeftShift) && GetInput();

    private bool GetInput()
       => _player.InpuZ != 0 || _player.InpuX != 0;

}
