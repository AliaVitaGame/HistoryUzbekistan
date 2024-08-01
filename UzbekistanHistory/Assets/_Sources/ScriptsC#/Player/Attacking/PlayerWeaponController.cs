using UnityEngine;

[RequireComponent(typeof(PlayerMeleeAttacking))]
[RequireComponent(typeof(PlayerDistanceAttacking))]
public class PlayerWeaponController : MonoBehaviour
{
    private PlayerMeleeAttacking _melee;
    private PlayerDistanceAttacking _distance;

    private void Start()
    {
        _melee = GetComponent<PlayerMeleeAttacking>();
        _distance = GetComponent<PlayerDistanceAttacking>();
    }

    public void SetWeapon(WeaponScriptableObject weapon)
    {
        if (weapon is IMeleeWeapon meleeWeapon)
            _melee.SetWeapon(meleeWeapon);
        else if (weapon is IDistanceWeapon distanceWeapon)
            _distance.SetWeapon(distanceWeapon);
    }
}
