using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IntroManager : MonoBehaviour
{
    [SerializeField]
    private float TimeBeforeIntro = 15f;

    [SerializeField]
    private List<GameObject> bulkLights;

    [SerializeField]
    private List<GameObject> alertBulkLights;

    [SerializeField]
    private List<GameObject> lights;

    [SerializeField]
    private List<GameObject> alertLights;

    [SerializeField]
    private Material closedMaterial;

    [SerializeField]
    private Material alertMaterial;

    [SerializeField]
    private Material openedMaterial;

    [SerializeField]
    private List<GameObject> removeableObjects;

    [SerializeField]
    private GameObject keyObjectsHighlights;

    [SerializeField]
    private GameObject removeableTubeLight;

    [SerializeField]
    private GameObject HatchHandle;

    [SerializeField]
    private GameObject cameraUI;

    [SerializeField]
    private AudioSource submarineAudio;
    [SerializeField]
    private AudioSource submarineAudio2;
    [SerializeField]
    private AudioSource audioSubmarineCrash;
    [SerializeField]
    private AudioClip audioVoiceCrash;
    [SerializeField]
    private AudioClip audioVoiceRepair;
    [SerializeField]
    private AudioClip audioVoiceItems;
    [SerializeField]
    private AudioClip audioVoiceInstructions;


    private bool intro = true;

    void Start()
    {
        StartCoroutine(Intro());
    }

    IEnumerator Intro()
    {
        yield return new WaitForSeconds(TimeBeforeIntro);

        foreach (GameObject obj in alertBulkLights) {
            obj.GetComponent<MeshRenderer>().material = alertMaterial;
        }

        foreach (GameObject obj in alertLights) {
            obj.SetActive(true);
        }

        submarineAudio.Play();
        submarineAudio2.Play();

        yield return new WaitForSeconds(4f);

        foreach (GameObject obj in bulkLights) {
            obj.GetComponent<MeshRenderer>().material = closedMaterial;
        }

        foreach (GameObject obj in lights) {
            obj.SetActive(false);
        }

        yield return new WaitForSeconds(4f);

        foreach (GameObject obj in alertBulkLights) {
            obj.GetComponent<MeshRenderer>().material = closedMaterial;
        }

        foreach (GameObject obj in alertLights) {
            obj.SetActive(false);
        }

        submarineAudio.Stop();
        submarineAudio2.Stop();
        audioSubmarineCrash.Play();
        while ( audioSubmarineCrash.isPlaying )
        {
            yield return null;
        }

        yield return new WaitForSeconds(1f);

        foreach (GameObject obj in alertBulkLights) {
            obj.GetComponent<MeshRenderer>().material = alertMaterial;
        }

        foreach (GameObject obj in alertLights) {
            obj.GetComponent<AlertLightController>().alert = true;
            obj.SetActive(true);
        }

        yield return new WaitForSeconds(1f);

        submarineAudio.clip = audioVoiceCrash;
        submarineAudio2.clip = audioVoiceCrash;
        submarineAudio.Play();
        submarineAudio2.Play();
        while ( submarineAudio.isPlaying )
        {
            yield return null;
        }

        yield return new WaitForSeconds(3f);

        submarineAudio.clip = audioVoiceRepair;
        submarineAudio2.clip = audioVoiceRepair;
        submarineAudio.Play();
        submarineAudio2.Play();
        while ( submarineAudio.isPlaying )
        {
            yield return null;
        }

        yield return new WaitForSeconds(1f);

        DisperseItems();

        submarineAudio.clip = audioVoiceItems;
        submarineAudio2.clip = audioVoiceItems;
        submarineAudio.Play();
        submarineAudio2.Play();

        yield return new WaitForSeconds(3f);

        cameraUI.SetActive(true);

        while ( submarineAudio.isPlaying )
        {
            yield return null;
        }
        submarineAudio.clip = audioVoiceInstructions;
        submarineAudio2.clip = audioVoiceInstructions;
        submarineAudio.Play();
        submarineAudio2.Play();
    }

    private void DisperseItems()
    {
        foreach (GameObject obj in removeableObjects) {
            obj.SetActive(false);
        }

        keyObjectsHighlights.SetActive(true);

        HatchHandle.SetActive(true);

        removeableTubeLight.GetComponent<MeshRenderer>().material = alertMaterial;
    }
}
