using UnityEngine;

public class EquippedItemPlayer : MonoBehaviour
{
    [SerializeField] private CellEquippedItem _cellHelmet;
    [SerializeField] private CellEquippedItem _cellArmor;
    [SerializeField] private CellEquippedItem _cellGloves;
    [SerializeField] private CellEquippedItem _cellGreaves;
    [SerializeField] private CellEquippedItem _cellBoots;
    [SerializeField] private CellEquippedItem _cellRing;
    [Space]
    [SerializeField] private InventoryPlayer inventoryPlayer;
    [Space]
    [SerializeField] private AudioFX audioFX;
    [SerializeField] private AudioClip equipAudio;

    private Item _lastItem;

    public void Equip(ICell itemCell)
    {
        var item = itemCell.GetItem();
        if (item.Type == Item.TypeItem.Helmet)
        {
            HasItemCell(_cellHelmet);
            _cellHelmet.AddItem(item);
        }
        else if (item.Type == Item.TypeItem.Armor)
        {
            HasItemCell(_cellArmor);
            _cellArmor.AddItem(item);

        }
        else if (item.Type == Item.TypeItem.Gloves)
        {
            HasItemCell(_cellGloves);
            _cellGloves.AddItem(item);
        }
        else if (item.Type == Item.TypeItem.Greaves)
        {
            HasItemCell(_cellGreaves);
            _cellGreaves.AddItem(item);
        }
        else if (item.Type == Item.TypeItem.Boots)
        {
            HasItemCell(_cellBoots);
            _cellBoots.AddItem(item);
        }
        else if (item.Type == Item.TypeItem.Ring)
        {
            HasItemCell(_cellRing);
            _cellRing.AddItem(item);
        }

        itemCell.ReceiveItem();

        if (_lastItem)
        {
            inventoryPlayer.AddItem(_lastItem, 1);
            _lastItem = null;
        }

        audioFX.PlayAudio(equipAudio);
    }

    private void HasItemCell(ICell cell)
    {
        if(cell.HasItem())
            _lastItem = cell.GetItem();
    }

    public float GetDamageRepaymentPercentage()
    {
        return HelmetStats() + ArmorStats() + GlovesStats() + GreavesStats() + BootsStats();
    }

    public float HelmetStats()
    {
        return _cellHelmet.GetItem() ? _cellHelmet.GetItem().AddProtection : 0;
    }

    public float ArmorStats()
    {
        return _cellArmor.GetItem() ? _cellArmor.GetItem().AddProtection : 0;
    }

    public float GlovesStats()
    {
        return _cellGloves.GetItem() ? _cellGloves.GetItem().AddProtection : 0;
    }

    public float GreavesStats()
    {
        return _cellGreaves.GetItem() ? _cellGreaves.GetItem().AddProtection : 0;
    }

    public float BootsStats()
    {
        return _cellBoots.GetItem() ? _cellBoots.GetItem().AddProtection : 0;
    }

    public float RingStats()
    {
        return _cellRing.GetItem() ? _cellRing.GetItem().AddProtection : 0;
    }
}
