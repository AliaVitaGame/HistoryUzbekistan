using UnityEngine;

public class EnemyAnimationController : MonoBehaviour
{
    [SerializeField] private Animator animator;
    [SerializeField] private EnemyAttaking enemyAttaking;
    [SerializeField] private EnemyMove enemyMove;

    private void OnEnable()
    {
        enemyAttaking.StartAttackEvent += AnimationStartAttack;
        enemyAttaking.EndAttackEvent += AnimationEndAttack;
    }

    private void OnDisable()
    {
        enemyAttaking.StartAttackEvent -= AnimationStartAttack;
        enemyAttaking.EndAttackEvent -= AnimationEndAttack;
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

    private void AnimationStartAttack() => animator.SetBool("Attack", true);
    private void AnimationEndAttack() => animator.SetBool("Attack", false);

    private void Animation()
    {
        var agent = enemyMove.Agent;
        animator.SetBool("Move", agent.velocity.magnitude/ agent.speed > 0);
    }

   public AnimatorStateInfo GetStateInfo() 
        => animator.GetCurrentAnimatorStateInfo(0);
}
