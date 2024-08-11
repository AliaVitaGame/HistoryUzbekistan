using System.Collections;
using UnityEngine;

public interface IItem
{
    public GameObject ItemPrefab { get; }
    public int CountItem { get; set; }
    public Item GetItem();
    public void Destroy();
    public void SetCountItem(int count);
}

public interface IWeapon : IItem
{
    public float Damage {  get; }
    public RuntimeAnimatorController AnimatorOverride {  get; }
}

public interface IMeleeWeapon : IWeapon
{

}

public interface IDistanceWeapon : IWeapon
{

}

public interface IUnitHealthStats
{
    public float Health { get; set; }
    public float MaxHealth { get; set; }
    public bool IsDead { get; set; }
    public bool IsStunned { get; set; }
    public void TakeDamage(float damage, float timeStun, float repulsion);
    public IEnumerator StunTimer(float time);
}

public interface IUnitMeleeAttacking
{
    public float Damage { get; set; }
    public float AttackTime { get; set; }
    public float Repulsion { get; set; }
    public float StunTime { get; set; }
    public float RadiusDamage { get; set; }
    public bool IsAttacking { get; set; }
    public LayerMask LayerTarget { get; set; }
    public Vector2 DistanceDamage { get; set; }

    public void StartAttack(bool attackDown = false);
    public IEnumerator Attack();
    public IEnumerator AttackTimer(float time);
}

public interface IUnitDistanceAttacking
{
    public float Damage { get; set; }
    public float ReloadTime { get; set; }
    public float Repulsion { get; set; }
    public float StunTime { get; set; }
    public bool IsReload { get; set; }
    public float LifeTimeBullet { get; set; }
    public float SpeedMoveBullet { get; set; }

    public LayerMask LayerTarget { get; set; }
    public Bullet BulletPrefab { get; set; }
    public void StartShot(Transform target);
    public IEnumerator Shot(Transform target);
    public IEnumerator Reload();
}

public interface ISwitchColorHit
{
    public Color StartColor { get; set; }
    public Color HitColor { get; set; }
    public SpriteRenderer SpriteRenderer { get; set; }
    public void SetColorSprite(Color color);
}

public interface ICell
{
    public Item GetItem();
    public Item ReceiveItem();
    public bool HasItem();
}