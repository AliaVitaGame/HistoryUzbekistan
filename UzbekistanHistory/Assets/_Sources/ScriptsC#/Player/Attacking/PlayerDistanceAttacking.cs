using UnityEngine;

public class PlayerDistanceAttacking : MonoBehaviour
{
    private bool _isSelect;
    private IDistanceWeapon _weapon;

    public void SetWeapon(IDistanceWeapon weapon)
    {
        this._weapon = weapon;
    }

    public void Select() => _isSelect = true;
    public void Deselect() => _isSelect = false;
    public GameObject GetPrefab() => _weapon.ItemPrefab;
}
