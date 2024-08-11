using System;
using UnityEngine;

public class ManagerUI : MonoBehaviour
{
    public static Action<bool> OpenUIEvent;
    public static ManagerUI Instance;

    private void Awake()
    {
        Instance = this;
    }

    public void OpenUI(bool active)
    {
        OpenUIEvent?.Invoke(active);
    }
}
