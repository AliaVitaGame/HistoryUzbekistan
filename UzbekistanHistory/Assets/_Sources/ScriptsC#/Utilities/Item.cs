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
    [SerializeField] private string nameItemRU = "Предмет";
    [SerializeField] private string nameItemEN = "Item";
    [SerializeField] private string nameItemTR = "Öğe";
    [SerializeField, TextArea(7,7)] private string descriptionRU = "Без описания";
    [SerializeField, TextArea(7,7)] private string descriptionEN = "No description";
    [SerializeField, TextArea(7,7)] private string descriptionTR = "açıklama yok";

    public TypeItem Type => typeItem;
    public Sprite Sprite => spriteItem;
    public bool IsStack => isStack;
    public bool IsEquip => isEquip;
    public float AddProtection => addProtection;
    public float AddSpeed => addSpeed;
    public float AddHealth => addHealth;
    public float AddMana => addMana;
    public string DescriptionRU => descriptionRU;
    public string DescriptionEN => descriptionEN;
    public string DescriptionTR => descriptionTR;
    public int Price => price;
    public string NameItemRU => nameItemRU;
    public string NameItemEN => nameItemEN;
    public string NameItemTR => nameItemTR;

    public enum TypeItem
    {
        Coin = 0,
        Recovery = 1,

        Helmet = 2,
        Armor = 3,
        Gloves = 4,
        Greaves = 5,
        Boots = 6,
        Ring = 7,

        Magic = 8
    }
}
