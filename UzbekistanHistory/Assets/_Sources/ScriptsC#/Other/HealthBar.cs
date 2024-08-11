using UnityEngine;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour
{
    [SerializeField] private bool notDeleteWithoutParent;
    [SerializeField] private Image healthImage;

    private Vector3 _startPosition;
    private Transform _parent;
    private bool _isUnpin;

    public void Unpin()
    {
        _isUnpin = true;
        _startPosition = transform.localPosition;
        _startPosition.x = 0;
        _parent = transform.parent;
        transform.SetParent(null);
    }

    private void FixedUpdate()
    {
        if(_parent == null && notDeleteWithoutParent == false)
        {
            Destroy(gameObject);
            return;
        }

        if (_isUnpin)
        transform.position = _parent.position + _startPosition;
    }

    public void SetHealth(float health, float maxHealth) 
        => healthImage.fillAmount = health / maxHealth;
}
