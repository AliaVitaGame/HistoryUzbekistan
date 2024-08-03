using UnityEngine;

public class WeaponScriptableObject : ScriptableObject, IWeapon
{
    [SerializeField] private float damage;
    [SerializeField] private GameObject itemPrefab;
    [SerializeField] private RuntimeAnimatorController animatorOverride;

    public float Damage => damage;
    public GameObject ItemPrefab => itemPrefab;
    public RuntimeAnimatorController AnimatorOverride => animatorOverride;

}
