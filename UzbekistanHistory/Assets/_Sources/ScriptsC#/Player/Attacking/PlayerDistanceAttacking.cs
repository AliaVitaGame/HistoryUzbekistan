using UnityEngine;

public class PlayerDistanceAttacking : MonoBehaviour
{
    private IDistanceWeapon _weapon;

    public void SetWeapon(IDistanceWeapon weapon)
    {
        this._weapon = weapon;
    }

    public GameObject GetPrefab() => _weapon.ItemPrefab;
}
