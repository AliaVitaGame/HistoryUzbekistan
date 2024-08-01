using UnityEngine;

public class WeaponScriptableObject : ScriptableObject, IWeapon
{
    [SerializeField] private float damage;
    [SerializeField] private GameObject itemPrefab;

    public float Damage => damage;
    public GameObject ItemPrefab => itemPrefab;

    public IWeapon GetInterface() => this;
}
