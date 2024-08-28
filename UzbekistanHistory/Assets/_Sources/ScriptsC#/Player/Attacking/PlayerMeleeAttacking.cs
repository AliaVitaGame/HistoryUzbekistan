using System.Collections;
using UnityEngine;

public class PlayerMeleeAttacking : MonoBehaviour
{
    private PlayerMove _playerMove;
    private PlayerAnimationController _animationController;
    private IMeleeWeapon _weapon;
    private Collider _weaponCollider;

    private float _timeAttack = 1.5f;
    private bool _isAttacking;
    private bool _isSelect;
    private int _countAnimationAttack = 5; // 1 - 5

    private void Start()
    {
        _animationController = GetComponent<PlayerAnimationController>();
        _playerMove = GetComponent<PlayerMove>();
    }

    private void Update()
    {
        if (_isSelect == false) return;

        if (Input.GetMouseButtonDown(0))
            StartAttack();
    }

    public void StartAttack()
    {
        if (_isAttacking) return;
        StartCoroutine(Attack());
    }

    public IEnumerator Attack()
    {
        _isAttacking = true;
        _weaponCollider.enabled = true;
        _playerMove.SetStopMove(true);

        var direction = _playerMove.GetPivotDirection().forward;
        _playerMove.SetRotation(direction);
        _playerMove.SetModelRotation(direction);

        int randomAttack = Random.Range(1, _countAnimationAttack + 1);

        _animationController.AttackAnimation(randomAttack);
        _timeAttack = GetTimeAnimation();

        _animationController.SetApplyRootMotion(true);

        yield return new WaitForSeconds(_timeAttack);

        _weaponCollider.enabled = false;
        _animationController.AttackAnimation(randomAttack, false);
        _isAttacking = false;
        _playerMove.SetStopMove(false);

        _animationController.SetApplyRootMotion(false);
    }

    private float GetTimeAnimation()
    {
        var animator = _animationController.GetAnimator();
        var animatorController = animator.runtimeAnimatorController;
        return 1.2f;
    }

    public void Select() => _isSelect = true;
    public void Deselect() => _isSelect = false;

    public void SetWeapon(IMeleeWeapon weapon) 
        => _weapon = weapon;
    public GameObject GetPrefab() 
        => _weapon.ItemPrefab;
    public void SetWeaponObject(GameObject weaponCollider)
    {
        _weaponCollider = weaponCollider.GetComponent<Collider>();
        _weaponCollider.enabled = false;
    }
}
