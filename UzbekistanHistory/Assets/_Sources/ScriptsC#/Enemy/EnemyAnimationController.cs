using UnityEngine;

public class EnemyAnimationController : MonoBehaviour
{
    [SerializeField] private Animator animator;
    [SerializeField] private EnemyAttaking enemyAttaking;
    [SerializeField] private EnemyMove enemyMove;
    [SerializeField] private EnemyStats enemyStats;

    private void OnEnable()
    {
        enemyAttaking.StartAttackEvent += AnimationStartAttack;
        enemyAttaking.EndAttackEvent += AnimationEndAttack;
        enemyStats.DaadEvent += DeadAnimation;
        enemyStats.StunEvent += HitAnimation;
    }

    private void OnDisable()
    {
        enemyAttaking.StartAttackEvent -= AnimationStartAttack;
        enemyAttaking.EndAttackEvent -= AnimationEndAttack;
        enemyStats.DaadEvent -= DeadAnimation;
        enemyStats.StunEvent -= HitAnimation;
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
    private void DeadAnimation() => animator.SetTrigger("Dead");

    public void HitAnimation(bool active)
    {
        if (active) animator.SetTrigger("HitTrigger");
        animator.SetBool("Hit", active);
    }

    private void Animation()
    {
        if (enemyStats.IsStunned) return;

        var agent = enemyMove.Agent;

        bool isMove = agent.velocity.magnitude / agent.speed > 0;
        animator.SetBool("Move", isMove && enemyMove.IsRunning == false);
        animator.SetBool("Run", isMove && enemyMove.IsRunning);
    }

    public AnimatorStateInfo GetStateInfo()
         => animator.GetCurrentAnimatorStateInfo(0);
}
