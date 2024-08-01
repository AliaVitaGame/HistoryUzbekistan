using UnityEngine;

public class PlayerMeleeAttacking : MonoBehaviour
{
    private IMeleeWeapon weapon;

    public void SetWeapon(IMeleeWeapon weapon)
    {
        this.weapon = weapon;
    }
}
