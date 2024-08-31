using System;
using System.Collections;
using UnityEngine;

[RequireComponent(typeof(EnemyMove))]
[RequireComponent(typeof(EnemyAnimationController))]
public class EnemyStats : MonoBehaviour, IUnitHealthStats
{
    [SerializeField] private float health;
    [SerializeField] private float maxHealth;
    [SerializeField] private ParticleSystem bloodFX;
    [Space]
    [SerializeField] private AudioClip[] damageAudio;
    [SerializeField] private AudioClip[] bloodAudio;
    [SerializeField] private AudioClip[] deadAudio;
    [SerializeField] private AudioFX audioFX;

    public float Health
    {
        get => health;
        set => health = Mathf.Clamp(value, 0, maxHealth);
    }
    public float MaxHealth
    {
        get => maxHealth;
        set => maxHealth = Mathf.Clamp(value, 0, Mathf.Infinity);
    }
    public bool IsDead { get; set; }
    public bool IsStunned { get; set; }

    public Action PlayerHitEvent;
    public Action PlayerDaadEvent;

    private EnemyMove _enemyMove;
    private EnemyAnimationController _animationController;

    private void Start()
    {
        _enemyMove = GetComponent<EnemyMove>();
        _animationController = GetComponent<EnemyAnimationController>();

        RefreshHealthBar();
    }

    public void TakeDamage(float damage, float timeStun = 1, float repulsion = 0)
    {
        if (IsDead) return;
    
        audioFX.PlayAudioRandomPitch(damageAudio[GetRandomValue(0, damageAudio.Length)]);
        audioFX.PlayAudioRandomPitch(bloodAudio[GetRandomValue(0, bloodAudio.Length)]);

        var damageTakenArmor = damage;
        Health -= damageTakenArmor;

        PlayerHitEvent?.Invoke();

        bloodFX.Play();

        RefreshHealthBar();

        if (Health <= 0)
        {
            Dead();
            return;
        }

        StartCoroutine(StunTimer(timeStun));
    }

    public IEnumerator StunTimer(float time)
    {
        IsStunned = true;
        _animationController.HitAnimation(true);
        yield return new WaitForSeconds(time);
        IsStunned = false;
        _animationController.HitAnimation(false);
    }

    private void Dead()
    {
        IsDead = true;
        DeadAudio();
        PlayerDaadEvent?.Invoke();
    }

    public void AddHealth(float value)
    {
        Health += value;
        RefreshHealthBar();
    }

    public void Resurrect()
    {
        IsDead = false;
        Health = maxHealth;
        RefreshHealthBar();
        audioFX.transform.SetParent(transform);
    }

    private void DeadAudio()
    {
        audioFX.transform.SetParent(null);
        audioFX.PlayAudioRandomPitch(deadAudio[GetRandomValue(0, deadAudio.Length)]);
    }

    private void RefreshHealthBar()
    {
        // _healthBar.SetHealth(Health, MaxHealth);
    }

    private int GetRandomValue(int min, int max)
        => UnityEngine.Random.Range(min, max);
}
