using System;
using UnityEngine;
using UnityEngine.UI;

public class CellEquippedItem : MonoBehaviour, ICell
{
    [SerializeField] private Item itemCell;
    [SerializeField] private Sprite nullSprite;
    [Space]
    [SerializeField] private Color selectColor = Color.green;
    [SerializeField] private Color deselectColor = Color.white;

    private Image _imageCell;
    private Image _backImageCell;
    private bool _isSelect;
    public static Action CellEquippedDeselectEvent;
    public static Action<CellEquippedItem, bool> CellEquippedSelectEvent;

    private static Action<CellEquippedItem> _selectNewCell;

    private void OnEnable()
    {
        _selectNewCell += AutoDeselect;
    }

    private void OnDisable()
    {
        _selectNewCell -= AutoDeselect;
    }

    private void Start()
    {
        InitializationUI();
        GetComponent<Button>().onClick.AddListener(Select);
    }

    public void AddItem(Item item)
    {
        itemCell = item;
        RefreshUI(item.Sprite);
    }

    public void Clear()
    {
        itemCell = null;
        RefreshUI(nullSprite);
    }


    public Item ReceiveItem()
    {
        var item = itemCell;

        Deselect();
        Clear();

        return item;
    }

    public void Select()
    {
        _selectNewCell?.Invoke(this);

        if (HasItem() == false)
        {
            Deselect();
            return;
        }

        _isSelect = !_isSelect;

        SetColorBackImage(selectColor);

        if (_isSelect) CellEquippedSelectEvent?.Invoke(this, true);
        else Deselect();
    }

    public void Deselect()
    {
        _isSelect = false;
        CellEquippedDeselectEvent?.Invoke();
        SetColorBackImage(deselectColor);
    }

    private void AutoDeselect(CellEquippedItem cellInventory)
    {
        if (cellInventory != this) Deselect();
    }

    private void RefreshUI(Sprite sprite)
    {
        InitializationUI();
        _imageCell.sprite = sprite;
    }

    public Item GetItem() => itemCell;
    public bool HasItem() => itemCell;
    public Item.TypeItem GetItemType() => itemCell.Type;
    public void SetColorBackImage(Color color) => _backImageCell.color = color;

    private void InitializationUI()
    {
        if (_imageCell == null) _imageCell = transform.GetChild(0).GetComponent<Image>();
        if (_backImageCell == null) _backImageCell = transform.GetComponent<Image>();
    }
}
