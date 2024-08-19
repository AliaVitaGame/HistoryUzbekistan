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

        if (playerAnimationController == null)
        {
            if (transform.TryGetComponent(out PlayerAnimationController playerAnimation))
                playerAnimationController = playerAnimation;
            else
                Debug.LogError("Player animator not found");
        }
    }

    public void SetWeapon(Item weapon)
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

    public void RemoveWeapon(Item item)
    {
        if (item is IMeleeWeapon meleeWeapon)
            Destroy(_meleeObject.gameObject);
        else if (item is IDistanceWeapon distanceWeapon)
            Destroy(_distanceObject.gameObject);

        playerAnimationController.ReturnStartingAnimator();
    }


    private void SpawnObject(bool isMelee)
    {
        var weaponPrefab = isMelee ? _melee.GetPrefab() : _distance.GetPrefab();
        var pivotTrs = pivotSpawnWeapon.transform;
        var tempWeapon = Instantiate(weaponPrefab, pivotTrs.position, pivotTrs.transform.rotation, pivotTrs);

        if (isMelee) _meleeObject = tempWeapon;
        else _distanceObject = tempWeapon;
    }

    private void SetAnimator(RuntimeAnimatorController controller)
        => playerAnimationController.SetAnimator(controller);
}
