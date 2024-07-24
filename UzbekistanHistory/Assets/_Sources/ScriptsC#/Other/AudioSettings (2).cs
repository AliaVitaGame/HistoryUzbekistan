using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;

public class AudioSettings : MonoBehaviour
{
    [SerializeField] private Slider musicVolumeSlider;
    [SerializeField] private Slider audioEffectsVolumeSlider;
    [Space]
    [SerializeField] private string nameMusicVolumeExpose = "Music";
    [SerializeField] private string nameAudioEffectsVolumeExpose = "SFX";
    [SerializeField] private AudioMixer audioMixer;

    private static float _musicVolume;
    private static float _audioEffectsVolume;


    private void Start() => LoadSettings();

    public void SetVolumeMusic(float value)
    {
        _musicVolume = value;
        audioMixer.SetFloat(nameMusicVolumeExpose, value);
    }

    public void SetVolumeAudioEffects(float value)
    {
        _audioEffectsVolume = value;
        audioMixer.SetFloat(nameAudioEffectsVolumeExpose, value);
    }

    public void LoadSettings()
    {
        musicVolumeSlider.minValue = -80;
        audioEffectsVolumeSlider.minValue = -80;

        musicVolumeSlider.maxValue = 0;
        audioEffectsVolumeSlider.maxValue = 0;

        musicVolumeSlider.value = _musicVolume;
        audioEffectsVolumeSlider.value = _audioEffectsVolume;  

        audioMixer.SetFloat(nameMusicVolumeExpose, _musicVolume);
        audioMixer.SetFloat(nameAudioEffectsVolumeExpose, _audioEffectsVolume);
    }
}
