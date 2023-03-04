using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioManager : MonoBehaviour
{
    [SerializeField]
    private AudioSource ambientAudioSource;
    [SerializeField]
    private AudioSource helmetAudioSource;

    [SerializeField]
    private AudioClip audioAmbientOutside;
    [SerializeField]
    private AudioClip audioAmbientSubmarine;
    [SerializeField]
    private AudioClip audioTubePickup;
    [SerializeField]
    private AudioClip audioLeverPickup;
    [SerializeField]
    private AudioClip audioValvePickup;
    [SerializeField]
    private AudioClip audioSubmarineDenied;
    [SerializeField]
    private AudioClip audioCaveDenied;
    [SerializeField]
    private AudioClip audioLastZoneDenied;

    private int state = 0;

    public void SetOutsideAmbient()
    {
        ambientAudioSource.Stop();
        ambientAudioSource.clip = audioAmbientOutside;
        ambientAudioSource.Play();
    }

    public void SetSubmarineAmbient()
    {
        ambientAudioSource.Stop();
        ambientAudioSource.clip = audioAmbientSubmarine;
        ambientAudioSource.Play();
    }

    public void PlayTubePickupSound()
    {
        if (state == 0) {
            helmetAudioSource.Stop();
            helmetAudioSource.clip = audioTubePickup;
            helmetAudioSource.Play();
            state++;
        }
    }

    public void PlayLeverPickupSound()
    {
        if (state == 1) {
            helmetAudioSource.Stop();
            helmetAudioSource.clip = audioLeverPickup;
            helmetAudioSource.Play();
            state++;
        }
    }

    public void PlayValvePickupSound()
    {
        if (state == 2) {
            helmetAudioSource.Stop();
            helmetAudioSource.clip = audioValvePickup;
            helmetAudioSource.Play();
            state++;
        }
    }

    public void PlayEnterSubmarineDenied()
    {
        if (!helmetAudioSource.isPlaying) {
            helmetAudioSource.clip = audioSubmarineDenied;
            helmetAudioSource.Play();
        }
    }

    public void PlayEnterCaveDenied()
    {
        if (!helmetAudioSource.isPlaying) {
            helmetAudioSource.clip = audioCaveDenied;
            helmetAudioSource.Play();
        }
    }

    public void PlayEnterLastZoneDenied()
    {
        if (!helmetAudioSource.isPlaying) {
            helmetAudioSource.clip = audioLastZoneDenied;
            helmetAudioSource.Play();
        }
    }
}
