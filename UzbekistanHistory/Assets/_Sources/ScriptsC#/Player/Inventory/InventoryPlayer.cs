using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InventoryPlayer : MonoBehaviour
{
    [SerializeField] private int coinCount;
    [SerializeField] private Text coinCountText;
    [SerializeField] private List<CellInventory> Cells = new List<CellInventory>();

    private int _maxItemCountCell = 64;

    private int _remainderLastItem;

    private void Start()
    {
        RefreshUI();
    }

    public bool AddItem(Item item, int count)
    {
        int countItem = item.IsStack ? count : 1;
        int remains = 0;

        if(item.Type == Item.TypeItem.Coin)
        {
            coinCount += count;
            RefreshUI();
            return true;
        }

        if (item.IsStack)
        {
            for (int i = 0; i < Cells.Count; i++)
            {
                if (Cells[i].HasItem())
                {
                    if (Cells[i].GetItemType() == item.Type)
                    {
                        if (Cells[i].GetCountOblectCell() + countItem > _maxItemCountCell)
                        {
                            remains = Cells[i].GetCountOblectCell() + countItem - _maxItemCountCell;
                            Cells[i].AddItem(item, countItem - remains);
                            countItem = remains;
                            _remainderLastItem = countItem;
                        }
                        else
                        {
                            Cells[i].AddItem(item, countItem);
                            return true;
                        }
                    }
                }
            }
        }


        for (int i = 0; i < Cells.Count; i++)
        {
            if (Cells[i].HasItem() == false)
            {
                Cells[i].AddItem(item, countItem);
                return true;
            }
        }

        return false;
    }

    public int GetRemainderLastItem() => _remainderLastItem;

    private void RefreshUI()
    {
        coinCountText.text = $"${coinCount}";
    }
}
