using UnityEngine;

[RequireComponent(typeof(PlayerMeleeAttacking))]
[RequireComponent(typeof(PlayerDistanceAttacking))]
public class PlayerWeaponController : MonoBehaviour
{
    [SerializeField] private Transform pivotSpawnWeapon;
    [SerializeField] private PlayerAnimationController playerAnimationController;

    private GameObject _meleeObject;
    private GameObject _distanceObject;

    private PlayerMeleeAttacking _melee;
    private PlayerDistanceAttacking _distance;

    private void Start()
    {
        _melee = GetComponent<PlayerMeleeAttacking>();
        _distance = GetComponent<PlayerDistanceAttacking>();

        if(playerAnimationController == null)
        {
            if (transform.TryGetComponent(out PlayerAnimationController playerAnimation))
                playerAnimationController = playerAnimation;
            else
                Debug.LogError("Player animator not found");
        }   
    }

    public void SetWeapon(WeaponScriptableObject weapon)
    {
        if (weapon is IMeleeWeapon meleeWeapon)
        {
            _melee.SetWeapon(meleeWeapon);
            SpawnObject(true);
            SetAnimator(meleeWeapon.AnimatorOverride);
        }
        else if (weapon is IDistanceWeapon distanceWeapon)
        {
            _distance.SetWeapon(distanceWeapon);
            SpawnObject(false);
            SetAnimator(distanceWeapon.AnimatorOverride);
        }
    }

    private void SpawnObject(bool isMelee)
    {
        var weaponPrefab = isMelee ? _melee.GetPrefab() : _distance.GetPrefab();
        var tempWeapon = Instantiate(weaponPrefab, pivotSpawnWeapon.transform.position, Quaternion.identity);
        tempWeapon.transform.SetParent(pivotSpawnWeapon);

        if(isMelee) _meleeObject = tempWeapon;
        else _distanceObject = tempWeapon;
    }

    private void SetAnimator(RuntimeAnimatorController controller) 
        => playerAnimationController.SetAnimator(controller);
}
