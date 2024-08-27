using UnityEngine;

public class TimeScaleController : MonoBehaviour
{
    private static readonly float _startScale = 1;
    private static readonly float _stopScale = 0;

    private void Start() => SetScale(_startScale);

    public static void Play() => SetScale(_startScale);
    public static void Stop() => SetScale(_stopScale);
    public static void SetScale(float scale) => Time.timeScale = scale;
}
