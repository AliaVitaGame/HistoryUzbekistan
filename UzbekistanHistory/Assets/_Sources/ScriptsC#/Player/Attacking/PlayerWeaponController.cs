using UnityEngine;

[RequireComponent(typeof(PlayerMeleeAttacking))]
[RequireComponent(typeof(PlayerDistanceAttacking))]
public class PlayerWeaponController : MonoBehaviour
{
    [SerializeField] private LayerMask layerTarget;
    [SerializeField] private Transform pivotSpawnWeapon;
    [SerializeField] private PlayerAnimationController animationController;

    private GameObject _meleeObject;
    private GameObject _distanceObject;

    private int _weaponSelectID;
    private PlayerMeleeAttacking _melee;
    private PlayerDistanceAttacking _distance;

    private void Start()
    {
        _melee = GetComponent<PlayerMeleeAttacking>();
        _distance = GetComponent<PlayerDistanceAttacking>();

        if (animationController == null)
        {
            if (transform.TryGetComponent(out PlayerAnimationController playerAnimation))
                animationController = playerAnimation;
            else
                Debug.LogError("Player animator not found");
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            if (_melee == null) return;
            _melee.Select();
            _distance.Deselect();
        }
        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            if (_distance == null) return;
            _distance.Select();
            _melee.Deselect();
        }
    }

    public void SetWeapon(Item weapon)
    {
        if (weapon is IMeleeWeapon meleeWeapon)
        {
            _melee.SetWeapon(meleeWeapon);
            SpawnObject(true);
            _melee.SetWeaponObject(_meleeObject);
            _melee.SetStats(weapon.Damage, layerTarget);

            if (_melee) _melee.Select();
            if (_distance) _distance.Select();

            SetAnimator(meleeWeapon.AnimatorOverride);
        }
        else if (weapon is IDistanceWeapon distanceWeapon)
        {
            SpawnObject(false);
            _distance.SetWeapon(distanceWeapon);
            SetAnimator(distanceWeapon.AnimatorOverride);
        }
    }

    public void RemoveWeapon(Item item)
    {
        if (item is IMeleeWeapon meleeWeapon)
            Destroy(_meleeObject.gameObject);
        else if (item is IDistanceWeapon distanceWeapon)
            Destroy(_distanceObject.gameObject);

        animationController.ReturnStartingAnimator();
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
        => animationController.SetAnimator(controller);
}
