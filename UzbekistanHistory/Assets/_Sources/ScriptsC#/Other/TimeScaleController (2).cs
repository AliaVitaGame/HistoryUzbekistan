using UnityEngine;

public class TimeScaleController : MonoBehaviour
{
    [SerializeField] private bool isDontDestroyOnLoad;

    public static TimeScaleController Instance { set; private get; }

    private void Awake()
    {
        if (Instance) Destroy(gameObject);
        else Instance = this;

        if (isDontDestroyOnLoad)
            DontDestroyOnLoad(gameObject);
    }

    public void SetTimeScale(float timeScale) => Time.timeScale = timeScale;
}
