using UnityEngine;

public class EnemyAnimationController : MonoBehaviour
{
    [SerializeField] private Animator animator;
    [SerializeField] private EnemyAttaking enemyAttaking;
    [SerializeField] private EnemyMove enemyMove;

    private void OnEnable()
    {
        enemyAttaking.StartAttackEvent += AnimationAttack;
    }

    private void OnDisable()
    {
        enemyAttaking.StartAttackEvent -= AnimationAttack;
    }

    private void Start()
    {
        if (animator == null)
            animator = GetComponentInChildren<Animator>();
    }

    private void Update()
    {
        Animation();
    }

    private void AnimationAttack()
    {
        animator.SetTrigger("Attack");
    }

    private void Animation()
    {
        var agent = enemyMove.Agent;
        // bool isGround = _player.CharacterController.isGrounded;

        animator.SetBool("Move", agent.velocity.magnitude/ agent.speed > 0);

        // _playerAnimator.SetBool("Jump", isGround == false);
    }
}
