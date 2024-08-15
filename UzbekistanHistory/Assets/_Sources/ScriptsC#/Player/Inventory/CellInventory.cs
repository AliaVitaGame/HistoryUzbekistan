using System;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
[RequireComponent(typeof(Button))]
public class CellInventory : MonoBehaviour, ICell
{
    [SerializeField] private Item itemCell;
    [SerializeField] private int countOblectCell;
    [SerializeField] private Sprite nullSprite;
    [Space]
    [SerializeField] private Color selectColor = Color.green;
    [SerializeField] private Color deselectColor = Color.white;

    private Image _imageCell;
    private Image _backImageCell;
    private Text _textCount;
    private bool _isSelect;
    public static Action CellDeselectEvent;
    public static Action<CellInventory, bool> CellSelectEvent;

    private static Action<CellInventory> _selectNewCell;

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

    public void AddItem(Item item, int count)
    {
        itemCell = item;
        countOblectCell += count;
        RefreshUI();
    }

    public void Clear()
    {
        itemCell = null;
        countOblectCell = 0;
        RefreshUI();
    }


    public Item ReceiveItem()
    {
        countOblectCell--;

        var item = itemCell;

        if (countOblectCell <= 0)
        {
            Deselect();
            Clear();
        }
        RefreshUI();
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

        if (_isSelect) CellSelectEvent?.Invoke(this, false);
        else Deselect();
    }

    public void Deselect()
    {
        _isSelect = false;
        CellDeselectEvent?.Invoke();
        SetColorBackImage(deselectColor);
    }

    private void AutoDeselect(CellInventory cellInventory)
    {
        if (cellInventory != this) Deselect();
    }

    private void RefreshUI()
    {
        InitializationUI();
        _imageCell.sprite = itemCell ? itemCell.Sprite : nullSprite;

        string text = HasItem() && countOblectCell > 1 ? $"{countOblectCell}" : null;
        _textCount.text = text;
    }

    public Item GetItem() => itemCell;
    public bool HasItem() => countOblectCell > 0;
    public Item.TypeItem GetItemType() => itemCell.Type;
    public int GetCountOblectCell() => countOblectCell;
    public void SetColorBackImage(Color color) => _backImageCell.color = color;
    public void SetCountOblectCell(int count) => countOblectCell = count;

    private void InitializationUI()
    {
        if (_imageCell == null) _imageCell = transform.GetChild(0).GetComponent<Image>();
        if (_textCount == null) _textCount = transform.GetChild(1).GetComponent<Text>();
        if (_backImageCell == null) _backImageCell = transform.GetComponent<Image>();
    }
}
