using System.Collections.Generic;
using UnityEngine;

public class WeaponDamageble : MonoBehaviour
{
    [SerializeField] private float radiusCollision = 0.1f;
    [SerializeField] private float centerUpCollision = 0.7f;

    private float _damage;
    private bool _activeCollision;
    private LayerMask _targetLayer;

    private List<Collider> _damageHasBeenDone = new List<Collider>();

    private void Start()
    {
        SetActiveCollision(false);
    }

    private void FixedUpdate()
    {
        if (_activeCollision == false) return;

        var tempObject = Physics.OverlapSphere(GetCenterCollision(), radiusCollision, _targetLayer);

        if (tempObject == null) return;
        if (tempObject.Length <= 0) return;

        for (int i = 0; i < tempObject.Length; i++)
        {
            if (tempObject[i])
            {
                for (int k = 0; k < _damageHasBeenDone.Count; k++)
                {
                    if (tempObject[i] == _damageHasBeenDone[k])
                        return;
                }

                if (tempObject[i].TryGetComponent(out IUnitHealthStats unitHealth))
                {
                    unitHealth.TakeDamage(_damage);
                    _damageHasBeenDone.Add(tempObject[i]);
                }
            }
        }
    }

    public void SetActiveCollision(bool value)
    {
        _activeCollision = value;
        if(value == false) _damageHasBeenDone.Clear();
    }

    public void SetStats(float damagem, LayerMask layerTarget)
    {
        _damage = damagem;
        SetLayerTarget(layerTarget);
    }

    public void SetLayerTarget(LayerMask mask)
        => _targetLayer = mask;

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.green;
        Gizmos.DrawWireSphere(GetCenterCollision(), radiusCollision);
    }

    private Vector3 GetCenterCollision() 
        => centerUpCollision * transform.forward * transform.lossyScale.z + transform.position;
}
