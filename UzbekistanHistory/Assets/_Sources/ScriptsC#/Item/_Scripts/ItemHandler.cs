using System.ComponentModel;
using UnityEngine;

public class ItemHandler : MonoBehaviour
{
    [SerializeField] private WeaponScriptableObject item;
    [SerializeField, Range(1, 64)] private int count;

    [SerializeField] private GameObject _objectWeapon;

    private void OnValidate()
    {
        if (_objectWeapon == null)
            SpawnObject(item.ItemPrefab);
    }

    private void Start()
    {
        if (_objectWeapon == null)
            SpawnObject(item.ItemPrefab);
    }

    public int GetCount() => count;
    public WeaponScriptableObject GetItem() => item;

    private GameObject SpawnObject(GameObject go)
    {
        if (transform.childCount > 0) _objectWeapon = GetComponentInChildren<WeaponDamageble>().gameObject;
        else _objectWeapon = Instantiate(go, transform);

        return _objectWeapon;
    }
}
