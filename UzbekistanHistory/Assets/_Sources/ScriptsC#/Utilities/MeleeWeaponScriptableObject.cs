using UnityEngine;

[CreateAssetMenu(menuName = "Weapon/MeleeWeapon", fileName = "MeleeWeapon")]
public class MeleeWeaponScriptableObject : ScriptableObject, IMeleeWeapon
{
    [SerializeField] private float damage;
    [SerializeField] private GameObject itemPrefab;
    [SerializeField] private RuntimeAnimatorController animatorOverride;

    public float Damage => damage;
    public GameObject ItemPrefab => itemPrefab;
    public RuntimeAnimatorController AnimatorOverride => animatorOverride;
}
