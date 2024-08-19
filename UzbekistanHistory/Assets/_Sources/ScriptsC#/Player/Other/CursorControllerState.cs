using UnityEngine;

public class CursorControllerState : MonoBehaviour
{
    [SerializeField] private ManagerUI managerUI;

    private void OnEnable() => ManagerUI.OpenUIEvent += RefreshState;

    private void OnDisable() => ManagerUI.OpenUIEvent -= RefreshState;

    private void Start()
    {
        if (managerUI == null)
            Debug.Log("UI manager object is empty");
    }

    private void RefreshState(bool isOpenUI)
    {
        Cursor.lockState = isOpenUI ? CursorLockMode.None : CursorLockMode.Locked;
    }

}
