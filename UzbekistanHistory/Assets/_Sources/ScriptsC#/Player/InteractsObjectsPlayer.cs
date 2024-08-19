using UnityEngine;

public class InteractsObjectsPlayer : MonoBehaviour
{
    [SerializeField] private Transform pivotMoveDirection;
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
            var tempInteractsObject = Physics.OverlapSphere(distance + pivotMoveDirection.position + pivotMoveDirection.forward, radiusAttack);

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
        if(pivotMoveDirection)
        Gizmos.DrawWireSphere(distance + pivotMoveDirection.position + pivotMoveDirection.forward, radiusAttack);
    }
}
