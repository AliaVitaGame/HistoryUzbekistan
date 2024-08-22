using System.Collections;
using UnityEngine;

public class PlayerMeleeAttacking : MonoBehaviour
{
    private PlayerMove _playerMove;
    private PlayerAnimationController _animationController;
    private IMeleeWeapon _weapon;

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
        _playerMove.SetStopMove(true);
        int randomAttack = Random.Range(1, _countAnimationAttack + 1);

        _animationController.AttackAnimation(randomAttack);

        _timeAttack = GetStateInfo(randomAttack);

        yield return new WaitForSeconds(_timeAttack);
    
        _animationController.AttackAnimation(randomAttack, false);
        _isAttacking = false;
        _playerMove.SetStopMove(false);
    }

    private float GetStateInfo(int ID)
    {
        RuntimeAnimatorController runtimeAnimatorController = _animationController.GetAnimator().runtimeAnimatorController;

        string animationName = $"Attack{ID}";
        foreach (AnimationClip clip in runtimeAnimatorController.animationClips)
        {
            if (clip.name == animationName)
            {
                Debug.Log(clip.name);
                return clip.length;
            }
        }
        return 1;
    }

    public void Select() => _isSelect = true;
    public void Deselect() => _isSelect = false;

    public void SetWeapon(IMeleeWeapon weapon)
    {
        _weapon = weapon;
    }

    public GameObject GetPrefab() => _weapon.ItemPrefab;
}
