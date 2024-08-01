using UnityEngine;

public class PlayerDistanceAttacking : MonoBehaviour
{
    private IDistanceWeapon weapon;

    public void SetWeapon(IDistanceWeapon weapon)
    {
        this.weapon = weapon;
    }
}
