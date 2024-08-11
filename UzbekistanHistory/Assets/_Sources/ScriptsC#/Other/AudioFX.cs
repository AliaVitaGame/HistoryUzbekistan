using UnityEngine;

public class AudioFX : MonoBehaviour
{
    [SerializeField] private AudioSource audioSource;

    private void Start()
    {
        if (audioSource == null)
            audioSource = gameObject.AddComponent<AudioSource>();
    }

    public void PlayAudio(AudioClip audio)
    {
        SetPitch(1);
        audioSource.PlayOneShot(audio);
    }

    public void PlayAudioRandomPitch(AudioClip audio, float minPitch = 0.9f, float maxPitch = 1.1f)
    {
        SetPitch(Random.Range(minPitch, maxPitch));
        audioSource.PlayOneShot(audio);
    }

    private void SetPitch(float pitch)
        => audioSource.pitch = pitch;
}
