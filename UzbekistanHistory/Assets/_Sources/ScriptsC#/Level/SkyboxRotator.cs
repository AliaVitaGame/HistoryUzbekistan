using UnityEngine;

public class SkyboxRotator : MonoBehaviour
{
    [SerializeField] private float rotationSpeed = 1.0f;

    void Update()
    {
        Material skyboxMaterial = RenderSettings.skybox;

        if (skyboxMaterial != null)
        {
            float rotation = Time.time * rotationSpeed;
            skyboxMaterial.SetFloat("_Rotation", rotation);
        }
    }
}
