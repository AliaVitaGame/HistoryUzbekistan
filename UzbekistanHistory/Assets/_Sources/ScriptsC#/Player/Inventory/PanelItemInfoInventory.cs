using UnityEngine;
using UnityEngine.UI;

public class PanelItemInfoInventory : MonoBehaviour
{
    [SerializeField] private Image cellItemImage;
    [SerializeField] private Text itemNameText;
    [SerializeField] private Text itemDescriptionText;
    [Space]
    [SerializeField] private Button useButton;
    [SerializeField] private Button sellButton;
    [SerializeField] private Button dropButton;
    [SerializeField] private Button takeOffButton;
    [Space]
    [SerializeField] private Sprite nullSprite;
    [Space]
    [SerializeField] private InventoryPlayer inventoryPlayer;
    [SerializeField] private EquippedItemPlayer _equippedItemPlayer;
    [SerializeField] private PlayerWeaponController weaponController;
    [Space]
    [SerializeField] private PlayerStats playerStats;

    private bool _isEquippedItem;
    private ICell _cellInventory;

    private string _nameItemBase;
    private string _descriptionItemBase;

    private void OnEnable()
    {
        CellInventory.CellSelectEvent += ShowInfo;
        CellInventory.CellDeselectEvent += DontShowInfo;

        CellEquippedItem.CellEquippedSelectEvent += ShowInfo;
        CellEquippedItem.CellEquippedDeselectEvent += DontShowInfo;
    }

    private void OnDisable()
    {
        CellInventory.CellSelectEvent -= ShowInfo;
        CellInventory.CellDeselectEvent -= DontShowInfo;

        CellEquippedItem.CellEquippedSelectEvent -= ShowInfo;
        CellEquippedItem.CellEquippedDeselectEvent -= DontShowInfo;
    }

    private void Start()
    {
        useButton.onClick.AddListener(Use);
        takeOffButton.onClick.AddListener(TakeOff);

        DontShowInfo();
    }

    public void Use()
    {
        if (_cellInventory == null) return;
        if (_cellInventory.GetItem() == null) return;

        var item = _cellInventory.GetItem();

        if (item.IsEquip)
        {
            _equippedItemPlayer.Equip(_cellInventory);
        }
        else if (item.Type == Item.TypeItem.Recovery)
        {
            playerStats.AddHealth(item.AddHealth);
            _cellInventory.ReceiveItem();
        }
        else
        {
            return;
        }

        RefreshUI();
    }

    public void TakeOff()
    {
        if (_cellInventory == null) return;
        if (_cellInventory.GetItem() == null) return;

        if (inventoryPlayer.AddItem(_cellInventory.GetItem(), 1))
        {
            weaponController.RemoveWeapon(_cellInventory.GetItem());
            _isEquippedItem = false;
            _cellInventory.ReceiveItem();
        }

        RefreshUI();
    }

    private void ShowInfo(ICell cellInventory, bool equipped)
    {
        var item = cellInventory.GetItem();
        cellItemImage.sprite = item.Sprite;

        itemNameText.text = item.NameItem;
        itemDescriptionText.text = item.Description;

        _isEquippedItem = equipped;
        _cellInventory = cellInventory;
        RefreshUI();
    }

    private void DontShowInfo()
    {
        if (_nameItemBase == null) _nameItemBase = itemNameText.text;
        if (_descriptionItemBase == null) _descriptionItemBase = itemDescriptionText.text;

        cellItemImage.sprite = nullSprite;
        itemNameText.text = _nameItemBase;
        itemDescriptionText.text = _descriptionItemBase;
        _cellInventory = null;
        RefreshUI();
    }

    private void RefreshUI()
    {
        var hasItem = _cellInventory != null;
        useButton.interactable = hasItem;
        sellButton.interactable = hasItem;
        dropButton.interactable = hasItem;

        useButton.gameObject.SetActive(_isEquippedItem == false);
        sellButton.gameObject.SetActive(_isEquippedItem == false);
        dropButton.gameObject.SetActive(_isEquippedItem == false);

        takeOffButton.gameObject.SetActive(_isEquippedItem);
    }
}
