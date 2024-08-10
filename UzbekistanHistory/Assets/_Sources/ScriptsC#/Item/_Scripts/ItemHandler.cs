using UnityEngine;

public class ItemHandler : MonoBehaviour
{
    [SerializeField] private WeaponScriptableObject item;

    private void Start()
    {
        SpawnObject(item.ItemPrefab);
    }

    private void SpawnObject(GameObject go) => Instantiate(go, transform);
}
