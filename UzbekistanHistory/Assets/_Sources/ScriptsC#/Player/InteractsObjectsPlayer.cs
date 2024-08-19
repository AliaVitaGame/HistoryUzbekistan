using UnityEngine;

public class InteractsObjectsPlayer : MonoBehaviour
{
    [SerializeField] private InventoryPlayer inventoryPlayer;
    [SerializeField] private float radiusAttack = 1;
    [SerializeField] private Vector3 distance;

    private void Start()
    {
        if (inventoryPlayer == null)
        {
            if (gameObject.TryGetComponent(out InventoryPlayer inventory))
                inventoryPlayer = inventory;
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.E))
        {
            var tempInteractsObject = Physics.OverlapSphere(distance + transform.position + transform.forward, radiusAttack);

            for (int i = 0; i < tempInteractsObject.Length; i++)
            {
                if (tempInteractsObject[i])
                {
                    if (tempInteractsObject[i].TryGetComponent(out ItemHandler handler))
                    {
                        if (inventoryPlayer.AddItem(handler))
                        {
                            Destroy(handler.gameObject);
                            break;
                        }
                    }
                }
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(distance + transform.position + transform.forward, radiusAttack);
    }
}
