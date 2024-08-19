using UnityEngine;

[RequireComponent(typeof(Camera))]
public class CameraController : MonoBehaviour
{
    [SerializeField] private float _speedZoom = 50;
    [SerializeField] private float _sensitivity = 300;
    [SerializeField] private float _minY = 40;
    [SerializeField] private float _maxY = 50;
    [SerializeField] private Transform _pivotDirection;

    private bool _isStop;
    private float XRotation;
    private float YRotation;
    private Camera _camera;

    private void OnEnable() 
        => ManagerUI.OpenUIEvent += RefreshState;
    private void OnDisable() 
        => ManagerUI.OpenUIEvent -= RefreshState;

    private void Start()
    {
        _camera = GetComponent<Camera>();
        Cursor.lockState = CursorLockMode.Locked;
    }

    private void Update()
    {
        if(_isStop) return;

        float mouseX = Input.GetAxis("Mouse X") * _sensitivity * Time.deltaTime; 
        float mouseY = Input.GetAxis("Mouse Y") * _sensitivity * Time.deltaTime;
        _camera.fieldOfView = Mathf.Clamp(_camera.fieldOfView + Input.GetAxis("Mouse ScrollWheel") * -_speedZoom, 20, 100);

        YRotation -= mouseY;
        YRotation = Mathf.Clamp(YRotation, -_minY, _maxY);

        XRotation += mouseX;

       _pivotDirection.transform.localRotation = Quaternion.Euler(YRotation, XRotation, 0);
    }

    private void RefreshState(bool isStop) => _isStop = isStop;
}
