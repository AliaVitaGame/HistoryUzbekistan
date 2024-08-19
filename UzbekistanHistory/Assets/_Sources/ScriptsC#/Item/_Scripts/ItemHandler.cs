using UnityEngine;

public class ItemHandler : MonoBehaviour
{
    [SerializeField] private WeaponScriptableObject item;
    [SerializeField, Range(1, 64)] private int count;

    private void Start()
    {
        SpawnObject(item.ItemPrefab);
    }

    public int GetCount() => count;    
    public WeaponScriptableObject GetItem() => item;    

    private void SpawnObject(GameObject go) => Instantiate(go, transform);
}
