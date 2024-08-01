using UnityEngine;

public class PlayerMeleeAttacking : MonoBehaviour
{
    private IMeleeWeapon _weapon;

    public void SetWeapon(IMeleeWeapon weapon)
    {
        _weapon = weapon;
    }

    public GameObject GetPrefab() => _weapon.ItemPrefab;
}
