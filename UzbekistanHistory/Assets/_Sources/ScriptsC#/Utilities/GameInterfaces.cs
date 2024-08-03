using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IItem
{
    public GameObject ItemPrefab { get; }
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