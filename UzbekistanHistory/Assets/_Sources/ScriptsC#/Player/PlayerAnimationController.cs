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
        

    void FixedUpdate()
    {
        Animation();
    }

    private void Animation()
    {
        if (InputShift())
        {
            _playerAnimator.SetBool("Run", true);
        }
        else
        {
            _playerAnimator.SetBool("Run", false);
            _playerAnimator.SetFloat("MoveZ", _player.InpuZ);
        }

        _playerAnimator.SetFloat("MoveX", _player.InpuX);
        _playerAnimator.SetBool("Move", _player.InpuZ != 0 || _player.InpuX != 0);
        _playerAnimator.SetBool("Jump", _player.CharacterController.isGrounded == false);
    }

    private void StartDeadAnimation()
        => _playerAnimator.SetTrigger("Dead");

    private bool InputShift()
        => Input.GetKey(KeyCode.LeftShift) && _player.InpuZ > 0 && _player.InpuX == 0;

}
