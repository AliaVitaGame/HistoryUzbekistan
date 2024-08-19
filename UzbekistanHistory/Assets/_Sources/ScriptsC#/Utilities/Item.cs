using UnityEngine;

[CreateAssetMenu(menuName = "Item", fileName = "Item")]
public class Item : ScriptableObject
{
    [Header("Main")]
    [SerializeField] private TypeItem typeItem;
    [SerializeField] private Sprite spriteItem;
    [SerializeField] private bool isStack;
    [SerializeField] private bool isEquip;
    [Space]
    [Header("Protection")]
    [SerializeField] private float addProtection;
    [SerializeField] private float addSpeed;
    [Header("Recovery")]
    [SerializeField] private float addHealth;
    [SerializeField] private float addMana;
    [Space]
    [Header("Other")]
    [SerializeField] private int price;
    [Space]
    [SerializeField] private string nameItem = "Предмет";
    [SerializeField, TextArea(7,7)] private string description = "Без описания";

    public TypeItem Type => typeItem;
    public Sprite Sprite => spriteItem;
    public bool IsStack => isStack;
    public bool IsEquip => isEquip;
    public float AddProtection => addProtection;
    public float AddSpeed => addSpeed;
    public float AddHealth => addHealth;
    public float AddMana => addMana;
    public string Description => description;
    public int Price => price;
    public string NameItem => nameItem;

    public enum TypeItem
    {
        Coin = 0,
        Recovery = 1,

        Sword = 2,
        Shield = 3,
        Helmet = 4,
        Armor = 5,
        Gloves = 6,
        Greaves = 7,
        Boots = 8,
        Ring = 9,

        Magic = 10
    }
}
