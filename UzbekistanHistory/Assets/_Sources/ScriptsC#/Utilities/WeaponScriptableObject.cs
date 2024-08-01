using UnityEngine;

public class WeaponScriptableObject : ScriptableObject, IWeapon
{
    [SerializeField] private float damage;
    [SerializeField] private GameObject itemPrefab;
    [SerializeField] private Animator animatorOverride;

    public float Damage => damage;
    public GameObject ItemPrefab => itemPrefab;
    public Animator AnimatorOverride => animatorOverride;

    public IWeapon GetInterface() => this;
}
